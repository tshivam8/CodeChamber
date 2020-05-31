package com.classes;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.sun.org.apache.xalan.internal.xsltc.dom.Filter;

public class RedirectFilter implements Filter {

public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    HttpServletRequest req=(HttpServletRequest)request;

    //check if "role" attribute is null
    if(req.getSession().getAttribute("clg")==null) {
        //forward request to login.jsp
        req.getRequestDispatcher("/index.jsp").forward(request, response);
    } else {
        chain.doFilter(request, response);
    }
}

@Override
public boolean test(int node) {
	// TODO Auto-generated method stub
	return false;
}
}