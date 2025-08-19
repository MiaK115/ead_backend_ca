package com.example.users.web;

import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
@RequestMapping("/api/users")
public class UserController {

  @GetMapping
  public List<Map<String,Object>> list() {
    return List.of(
      Map.of("id","u1","name","Alice"),
      Map.of("id","u2","name","Bob")
    );
  }

  @PostMapping
  public Map<String,Object> create(@RequestBody Map<String,Object> body) {
    body.putIfAbsent("id", UUID.randomUUID().toString());
    return body;
  }

  @DeleteMapping("/{id}")
  public Map<String,String> delete(@PathVariable String id) {
    return Map.of("deleted", id);
  }
}
