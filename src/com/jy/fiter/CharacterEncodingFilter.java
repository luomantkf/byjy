package com.jy.fiter;

import javax.servlet.*;
import java.io.IOException;

/**
 * 设置编码过滤器
 */
public class CharacterEncodingFilter implements Filter {

    protected FilterConfig filterConfig = null;
    protected String encoding = "";

    public void destroy() {
        filterConfig = null;
        encoding = null;
    }

    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain filterChain) throws IOException, ServletException {
        if (encoding != null) {
            //设置request和response的编程格式，注意两个都要设，若没设response的
            //charset，则在输出页面会显示乱码。
            request.setCharacterEncoding(this.encoding);
            response.setContentType("text/html;charset=utf-8");
        }
        //继续执行下一个过滤器
        filterChain.doFilter(request, response);
    }

    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        this.encoding = filterConfig.getInitParameter("encoding");

    }
}