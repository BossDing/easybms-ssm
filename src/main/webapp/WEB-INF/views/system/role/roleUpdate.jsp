<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改角色</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all"/>
</head>
<body class="childrenBody">
<form class="layui-form" id="roleFrm">
    <div class="layui-form-item">
        <label class="layui-form-label">角色名称</label>
        <div class="layui-input-block">
            <input type="hidden" name="id" value="${role.id}">
            <input type="text" name="name" value="${role.name}" placeholder="角色名称" lay-verify="required"
                   autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">角色备注</label>
        <div class="layui-input-block">
            <textarea type="text" name="remark" placeholder="角色备注" autocomplete="off"
                      class="layui-textarea">${role.remark}</textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">是否可用</label>
        <div class="layui-input-block">
            <input type="radio" name="available" autocomplete="off" title="是" value="1"
            ${role.available == 1 ? 'checked' : ''} class="layui-input">
            <input type="radio" name="available" autocomplete="off" title="否" value="0"
            ${role.available == 0 ? 'checked' : ''} class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center;">
        <button class="layui-btn" lay-submit="" lay-filter="updateRole">提交</button>
        <button class="layui-btn layui-btn-warm" type="reset">重置</button>
    </div>
</form>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['form', 'layer', 'jquery'], function () {
        var form = layui.form;
        var $ = layui.jquery;
        //如果父页面有layer就是用父页面的，没有就导入
        var layer = parent.layer === undefined ? layui.layer : parent.layer;

        //监听提交，使用layui form submit事件
        form.on('submit(updateRole)', function () {
            //form获取数据
            var data = $('#roleFrm').serialize();
            $.post(
                '${ctx}/role/updateRole.json',
                data,
                function (data) {
                    console.log(data);
                    if (data.code == 0) {
                        //弹出成功的提示
                        layer.msg(data.msg, {icon: 1, time: 2000});
                        //重载表格
                        parent.tableIns.reload();
                        //关闭窗口
                        var index = layer.getFrameIndex(window.name);
                        layer.close(index);
                    } else {
                        //弹出失败的提示
                        layer.msg(data.msg, {icon: 2, time: 3000});
                    }
                }
            );
            return false;
        });
    });
</script>
</body>
</html>
