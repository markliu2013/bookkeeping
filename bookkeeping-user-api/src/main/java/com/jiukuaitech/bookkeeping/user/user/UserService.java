package com.jiukuaitech.bookkeeping.user.user;

import com.jiukuaitech.bookkeeping.user.book.Book;
import com.jiukuaitech.bookkeeping.user.group.Group;
import com.jiukuaitech.bookkeeping.user.utils.CommonUtils;
import com.jiukuaitech.bookkeeping.user.book.BookRepository;
import com.jiukuaitech.bookkeeping.user.book.BookVOForList;
import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import com.jiukuaitech.bookkeeping.user.group.GroupRepository;
import com.jiukuaitech.bookkeeping.user.group.GroupVOForList;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.time.Instant;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Service
public class UserService {

    @Resource
    private UserRepository userRepository;

    @Resource
    private GroupRepository groupRepository;

    @Resource
    private UserGroupRelationRepository userGroupRelationRepository;

    @Resource
    private BookRepository bookRepository;

    @Resource
    private RedisTemplate<String, Integer> redisTemplate;

    @Value("${invite.code}")
    private String inviteCode;

    public User getUser(Integer userSignInId) {
        return userRepository.findById(userSignInId).orElseThrow(SessionUserNotFoundException::new);
    }

    @Transactional
    public boolean register(UserRegisterRequest request, HttpServletRequest httpServletRequest) {
        if (StringUtils.hasText(inviteCode) && !inviteCode.equals(request.getInviteCode())) {
            throw new InviteCodeErrorException();
        }
        // 检查用户名是否存在
        if (userRepository.findOneByUserName(request.getUserName()) != null) {
            throw new RegisterNameExistsException();
        }
        // 密码MD5之后保存
        User user = new User(request.getUserName(), CommonUtils.encodePassword(request.getPassword()));
        if (StringUtils.hasText(request.getEmail())) {
            user.setEmail(request.getEmail());
        }
        user.setNickName(request.getUserName());
        user.setIp(CommonUtils.getRealIP(httpServletRequest));
        user.setVipTime(Instant.now().toEpochMilli());
        user.setRegisterTime(Instant.now().toEpochMilli());
        // 注册之后，默认一个组
        Group group = new Group();
        group.setName("默认组");
        group.setDefaultCurrencyCode("CNY");
        groupRepository.save(group);

        Book book = new Book();
        book.setName("默认账本");
        book.setDefaultCurrencyCode("CNY");
        book.setGroup(group);
        bookRepository.save(book);

        user.setDefaultGroup(group);
        user.setDefaultBook(book);
        userRepository.save(user);

        group.setDefaultBook(book);
        group.setCreator(user);
        groupRepository.save(group);

        UserGroupRelation userGroupRelation = new UserGroupRelation(user, group, 1);
        userGroupRelationRepository.save(userGroupRelation);
        return true;
    }

    public boolean updatePassword(Integer userSignInId, UserUpdatePasswordRequest request) {
        User user = getUser(userSignInId);
        if (!user.getPassword().equals(CommonUtils.encodePassword(request.getOldPassword()))) {
            throw new OldPasswordErrorException();
        }
        user.setPassword(CommonUtils.encodePassword(request.getNewPassword()));
        userRepository.save(user);
        return true;
    }

    public UserSignInResponse signin(UserSignInRequest request) {
        UserSignInResponse userSignInResponse = new UserSignInResponse();
        User user = userRepository.findOneByUserName(request.getUserName());
        if (user == null || !user.getPassword().equals(CommonUtils.encodePassword(request.getPassword()))) {
            throw new SigninFailedException();
        }
        if (!user.getEnable()) throw new UserDisabledException();
        // 用户名和密码都正确
        String token = UUID.randomUUID().toString();
        UserSessionVO userSessionVO = UserSessionVO.fromEntity(user);
        // 写入redis服务
//        long rememberTime = 60*60; //不记住，这默认保存1小时。
//        if (request.getRemember()) {
//            rememberTime = 30*24*60*60;
//        }
        long rememberTime = 30*24*60*60;
        redisTemplate.boundValueOps(token).set(user.getId(), rememberTime, TimeUnit.SECONDS);
        userSignInResponse.setToken(token);
        userSignInResponse.setRemember(request.getRemember());
        userSignInResponse.setSessionVO(getSession(user.getId()));
        return userSignInResponse;
    }

    public SessionVO getSession(Integer userSignInId) {
        User user = getUser(userSignInId);
        SessionVO sessionVO = new SessionVO();
        sessionVO.setUserSessionVO(UserSessionVO.fromEntity(user));
        sessionVO.setDefaultBook(BookVOForList.fromEntity(user.getDefaultBook()));
        sessionVO.setDefaultGroup(GroupVOForList.fromEntity(user.getDefaultGroup()));
        return sessionVO;
    }

    public BookVOForList setDefaultBook(Integer id, Integer userSignInId) {
        User user = getUser(userSignInId);
        Group group = user.getDefaultGroup();
        Book po = bookRepository.findOneByGroupAndId(group, id).orElseThrow(ItemNotFoundException::new);
        group.setDefaultBook(po);
        user.setDefaultBook(po);
        groupRepository.save(group);
        userRepository.save(user);
        return BookVOForList.fromEntity(po);
    }

    public Integer setDefaultGroup(Integer id, Integer userSignInId) {
        User user = getUser(userSignInId);
        Group po = groupRepository.findById(id).orElseThrow(ItemNotFoundException::new);
        UserGroupRelation userGroupRelation = userGroupRelationRepository.findOneByUserAndGroup(user, po);
        if (userGroupRelation == null) {
            throw new ItemNotFoundException();
        }
        user.setDefaultGroup(po);
        user.setDefaultBook(po.getDefaultBook());
        userRepository.save(user);
        return po.getId();
    }

}
