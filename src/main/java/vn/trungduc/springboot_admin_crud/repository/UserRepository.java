package vn.trungduc.springboot_admin_crud.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.trungduc.springboot_admin_crud.entity.User;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // Tìm user theo username
    Optional<User> findByUsername(String username);

    // Kiểm tra trùng username / email
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);

    // Tìm kiếm User theo username hoặc fullName có phân trang
    Page<User> findByUsernameContainingIgnoreCaseOrFullNameContainingIgnoreCase(
            String username, String fullName, Pageable pageable);
}
