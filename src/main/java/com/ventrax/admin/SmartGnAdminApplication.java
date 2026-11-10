package com.ventrax.admin;

import de.codecentric.boot.admin.server.config.EnableAdminServer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@EnableAdminServer
public class SmartGnAdminApplication {
    public static void main(String[] args) {
        SpringApplication.run(SmartGnAdminApplication.class, args);
    }
}