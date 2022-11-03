package com.jiukuaitech.bookkeeping.user.flow_images;

import com.jiukuaitech.bookkeeping.user.response.BaseResponse;
import com.jiukuaitech.bookkeeping.user.response.DataResponse;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/flow-images")
public class FlowImageController {

    @Resource
    private FlowImageService flowImageService;

    @RequestMapping(method = RequestMethod.GET, value = "/upload-token")
    public BaseResponse handleUploadToken(@RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(flowImageService.uploadToken(userSignInId));
    }

    @RequestMapping(method = RequestMethod.POST, value = "/upload-callback")
    public BaseResponse handleUploadCallBack(@RequestBody UploadCallbackRequest request) {
        return new DataResponse<>(flowImageService.uploadCallBack(request));
    }

    @RequestMapping(method = RequestMethod.DELETE, value = "/{id}")
    public BaseResponse handleDelete(@PathVariable("id") Integer id, @RequestAttribute("userSignInId") Integer userSignInId) {
        return new DataResponse<>(flowImageService.remove(id, userSignInId));
    }

}
