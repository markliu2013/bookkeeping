package com.jiukuaitech.bookkeeping.user.flow_images;

import com.jiukuaitech.bookkeeping.user.user.User;
import com.jiukuaitech.bookkeeping.user.user.UserService;
import com.qiniu.util.Auth;
import com.qiniu.util.StringMap;
import com.jiukuaitech.bookkeeping.user.exception.ItemNotFoundException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.Optional;

@Service
public class FlowImageService {

    @Resource
    private FlowImageRepository flowImageRepository;

    @Resource
    private UserService userService;

    @Value("${upload.ACCESS_KEY}")
    private String uploadAK;

    @Value("${upload.SECRET_KEY}")
    private String uploadSK;

    @Value("${upload.FLOW_IMAGE_BUCKET}")
    private String uploadBucket;

    @Value("${upload.FLOW_IMAGE_HOST}")
    private String imageHost;

    @Value("${upload.FLOW_IMAGE_CALL_BACK_URL}")
    private String callBackUrl;

    public String uploadToken(Integer userSignInId) {
        Auth auth = Auth.create(uploadAK, uploadSK);
        StringMap putPolicy = new StringMap();
        String saveKey = userSignInId.toString() + "$(etag)" + ".jpg";
        putPolicy.put("saveKey", saveKey);
        putPolicy.put("fsizeMin", 1024); //1KB
        putPolicy.put("fsizeLimit", 15728640); //15M 用15*1024*1024报错
        putPolicy.put("mimeLimit", "image/jpeg;image/jpg;;image/png");
        putPolicy.put("fileType", 0); //0 为标准存储（默认），1 为低频存储，2 为归档存储。
        // 自定义上传回复的凭证
//        putPolicy.put("returnBody", "{\"key\":\"$(key)}\"");
        long expireSeconds = 3600;
        // 带回调业务服务器的凭证
        putPolicy.put("callbackUrl", callBackUrl);
        putPolicy.put("callbackBody", "{\"key\":\"$(key)\",\"userId\":$(x:userId)}");
        putPolicy.put("callbackBodyType", "application/json");
        return auth.uploadToken(uploadBucket, null, expireSeconds, putPolicy);
    }

    public FlowImageVOForList uploadCallBack(UploadCallbackRequest request) {
        User user = new User(request.getUserId());
        FlowImage image;
        Optional<FlowImage> optionalImage = flowImageRepository.findByUserAndUri(user, request.getKey());
        if(optionalImage.isPresent()) {
            image = optionalImage.get();
            if (image.getFlow() != null) throw new ImageExistsException();
        } else {
            image = new FlowImage();
            image.setHost(imageHost);
            image.setUri("/" + request.getKey());
            image.setUser(user);
            image.setCreateTime(System.currentTimeMillis());
            flowImageRepository.save(image);
        }
        return FlowImageVOForList.fromEntity(image);
    }

    public boolean remove(Integer id, Integer userSignInId) {
        User user = userService.getUser(userSignInId);
        FlowImage image = flowImageRepository.findByUserAndId(user, id).orElseThrow(ItemNotFoundException::new);
        image.setFlow(null);
        flowImageRepository.save(image);
        return true;
    }

}
