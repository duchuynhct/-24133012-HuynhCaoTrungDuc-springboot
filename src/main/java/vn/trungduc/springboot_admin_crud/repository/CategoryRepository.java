package vn.trungduc.springboot_admin_crud.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.trungduc.springboot_admin_crud.entity.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {

    // Tìm kiếm Category theo tên có phân trang
    Page<Category> findByCategoryNameContainingIgnoreCase(String keyword, Pageable pageable);
}
