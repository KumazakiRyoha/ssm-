package com.atguigu.crud.bean;

import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;

import java.util.HashMap;
import java.util.Map;

public class Msg {

    private int status;
    private String msg;

    //用户要返回给浏览器的数据
    private Map<String,Object> extend = new HashMap<String, Object>();

    public static Msg success(){
        Msg result = new Msg();
        result.setStatus(100);
        result.setMsg("处理成功");
        return result;
    }

    public static Msg failed(){
        Msg result = new Msg();
        result.setStatus(200);
        result.setMsg("处理失败");
        return result;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Msg(int status, String msg) {
        this.status = status;
        this.msg = msg;
    }

    public Msg() {
    }

    //链式调用
    public Msg add(String key,Object value){
        this.getExtend().put(key, value);
        return this;
    }
}
