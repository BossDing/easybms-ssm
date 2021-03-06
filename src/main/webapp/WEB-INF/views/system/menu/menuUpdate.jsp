<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改菜单</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all"/>
    <link rel="stylesheet" href="${ctx}/resources/zTree/css/metroStyle/metroStyle.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/plugin/css/index.css">
</head>
<body class="childrenBody">
<form class="layui-form" id="menuFrm">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">父级菜单</label>
            <div class="layui-input-inline">
                <%--使用selectTree 插件渲染部门层级下拉选择--%>
                <div class="layui-form-select select-tree" id="pid" name="pid"></div>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">排序码</label>
            <div class="layui-input-inline">
                <%--隐藏域存放id，提交表单数据时候一同提交--%>
                <input type="hidden" name="id" value="${menu.id}">
                <input type="hidden" name="type" value="${menu.type}">
                <input type="text" name="ordernum" value="${menu.ordernum}" placeholder="排序码"
                       lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">菜单名称</label>
        <div class="layui-input-block">
            <input type="text" name="name" value="${menu.name}" placeholder="菜单名称" lay-verify="required"
                   autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">菜单地址</label>
        <div class="layui-input-block">
            <input type="text" name="href" value="${menu.href}" placeholder="菜单地址" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">菜单图标</label>
            <div class="layui-input-inline">
                <input type="text" name="icon" value="${menu.icon}" lay-verify="required" id="icon" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">TARGET</label>
            <div class="layui-input-inline">
                <input type="text" name="target" value="${menu.target}" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">是否展开</label>
        <div class="layui-input-block">
            <input type="radio" name="open" autocomplete="off" title="是" value="1"
            ${menu.open == 1 ? 'checked' : ''} class="layui-input">
            <input type="radio" name="open" autocomplete="off" title="否" value="0"
            ${menu.open == 0 ? 'checked' : ''} class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <%--父节点的Ztree是一个文件夹样式，非父节点是一个文本--%>
        <label class="layui-form-label">是否父节点</label>
        <div class="layui-input-block">
            <input type="radio" name="parent" autocomplete="off" title="是" value="1"
            ${menu.parent == 1 ? 'checked' : ''} class="layui-input">
            <input type="radio" name="parent" autocomplete="off" title="否" value="0"
            ${menu.parent == 0 ? 'checked' : ''} class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">是否可用</label>
        <div class="layui-input-block">
            <input type="radio" name="available" autocomplete="off" title="是" value="1"
            ${menu.available == 1 ? 'checked' : ''} class="layui-input">
            <input type="radio" name="available" autocomplete="off" title="否" value="0"
            ${menu.available == 0 ? 'checked' : ''} class="layui-input">
        </div>
    </div>

    <div class="layui-form-item" style="text-align: center;">
        <button class="layui-btn" lay-submit="" lay-filter="updateMenu">提交</button>
        <button class="layui-btn layui-btn-warm" type="reset">重置</button>
    </div>
</form>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${ctx }/resources/plugin/js/selectTree.js"></script>
<script type="text/javascript">
    layui.use(['form', 'layer', 'jquery'], function () {
        var form = layui.form;
        var $ = layui.jquery;
        //如果父页面有layer就是用父页面的，没有就导入
        var layer = parent.layer === undefined ? layui.layer : parent.layer;

        //监听提交，使用layui form submit事件
        form.on('submit(updateMenu)', function () {
            //form获取数据
            var data = $('#menuFrm').serialize();
            $.post(
                '${ctx}/menu/updateMenu.json',
                data,
                function (data) {
                    console.log(data);
                    if (data.code == 0) {
                        //弹出成功的提示
                        layer.msg(data.msg, {icon: 1, time: 2000});
                        //重载表格
                        parent.tableIns.reload();
                        //刷新左边的部门树
                        parent.parent.left.initTree();
                        //关闭窗口
                        var index = layer.getFrameIndex(window.name);
                        layer.close(index);
                    }else {
                        //弹出失败的提示
                        layer.msg(data.msg, {icon: 2, time: 3000});
                    }
                }
            );
            return false;
        });
    });
    /**
     * 页面加载的时候也初始化部门树
     */
    $(function () {
        initMenuTree();
    });

    /**
    * 点击菜单图标，弹出一个选择菜单
    */
    $('#icon').focus(function() {
        var index = layui.layer.open( {
                title: '选择菜单图标',
                type: 2,
                area: ['700px', '600px'],
                content: "${ctx}/menu/toMenuSelectIcon.page",
                success: function (layero, index) {
                    setTimeout(function () {
                            layui.layer.tips('点击此处返回', '.layui-layer-setwin .layui-layer-close', {
                            tips: 3
                             });
                    }, 500);
                }
        });
        //默认所在文档中最大化窗口
        layui.layer.full(index);
    });

    /**
     * 加载可用的部门树
     */
    function initMenuTree() {
        $.post(
            '${ctx}/menu/menuTree.json',
            {"available": 1},
            function (zNodes) {
                //渲染下拉树
                initSelectTree('pid', zNodes, false);
                //渲染当前部门父节点，通过pid选中对应名称
                /**
                 * 注意：这里的zTree 的id，下拉树有做过特殊处理，id修改为：id(dom设置的id) + Tree组合成下拉树的id
                 */
                var zTreeObj = $.fn.zTree.getZTreeObj('pidTree');
                var pid = ${menu.pid};
                var node = zTreeObj.getNodeByParam('id',pid);
                zTreeObj.selectNode(node);
                //渲染,就相当于我点击了这个node节点，实现初始化下拉树数据
                onClick(event,'pidTree',node);

                $(".layui-nav-item a").bind("click", function () {
                    if (!$(this).parent().hasClass("layui-nav-itemed") && !$(this).parent().parent().hasClass("layui-nav-child")) {
                        $(".layui-nav-tree").find(".layui-nav-itemed").removeClass("layui-nav-itemed")
                    }
                });
            }
        );
    }
</script>
</body>
</html>
