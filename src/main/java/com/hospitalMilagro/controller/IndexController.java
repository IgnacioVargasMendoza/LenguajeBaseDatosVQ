package com.hospitalMilagro.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author Ignac
 */
@Controller
public class IndexController {
    
    @RequestMapping("/")
    public String page() {
        return "login/login";
    }
    
}
