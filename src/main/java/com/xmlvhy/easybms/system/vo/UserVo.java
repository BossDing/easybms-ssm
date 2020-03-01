package com.xmlvhy.easybms.system.vo;

import com.xmlvhy.easybms.system.entity.User;
import lombok.Data;

/**
 * @ClassName UserVo
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/04 16:38
 * @Version 1.0
 **/
@Data
public class UserVo extends User {
    /**
     * 用户id组成的数组，用于批量删除
     */
    private String[] ids;

    /**
     * 当前页码，匹配layui数据表格
     */
    private Integer page;

    /**
     * 每页的数据大小，匹配layui 数据表格
     */
    private Integer limit;
}
