package com.jiukuaitech.bookkeeping.user.tag_relation;

import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.validation.Valid;


@RestController
@RequestMapping("/tag-relations")
public class TagRelationController {

    @Resource
    private TagRelationService tagRelationService;

    @RequestMapping(method = RequestMethod.PUT, value = "/{id}")
    public BaseResponse handleUpdate(
            @PathVariable("id") Integer id,
            @Valid @RequestBody TagRelationUpdateRequest request,
            @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(tagRelationService.update(id, request, userSignInId));
    }

}
