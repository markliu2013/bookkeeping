package com.jiukuaitech.bookkeeping.user.flow_images;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FlowImageVOForList {

    private Integer id;
    private String url;
    private Integer userId;
    private Integer flowId;

    public static FlowImageVOForList fromEntity(FlowImage po) {
        if (po == null) return null;
        FlowImageVOForList vo = new FlowImageVOForList();
        vo.setId(po.getId());
        vo.setUrl(po.getHost() + po.getUri());
        vo.setUserId(po.getUser().getId());
        if (po.getFlow() != null) vo.setFlowId(po.getFlow().getId());
        return vo;
    }

}
