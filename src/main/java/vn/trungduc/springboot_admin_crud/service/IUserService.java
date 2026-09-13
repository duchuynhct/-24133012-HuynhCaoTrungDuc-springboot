package vn.trungduc.springboot_admin_crud.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.trungduc.springboot_admin_crud.entity.User;

import java.util.List;
import java.util.Optional;

public interface IUserService {

    Page<User> getAll(Pageable pageable);

    Page<User> search(String keyword, Pageable pageable);

    List<User> findAll();

    Optional<User> findById(Long id);

    Optional<User> findByUsername(String username);

    boolean existsByUsername(String username);

    boolean existsByEmail(String email);

    User save(User user);

    void deleteById(Long id);

    long count();
}
