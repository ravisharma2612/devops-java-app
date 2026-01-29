package com.example.devops.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/api/hello")
    public String hello() {
        return "Hello from DevOps Java Application 🚀";
    }

    @GetMapping("/api/version")
    public String version() {
        return "Version 1.0.0";
    }
}
