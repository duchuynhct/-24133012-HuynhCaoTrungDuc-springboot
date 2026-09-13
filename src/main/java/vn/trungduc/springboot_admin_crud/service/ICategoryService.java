package vn.trungduc.springboot_admin_crud.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.trungduc.springboot_admin_crud.entity.Category;

import java.util.List;
import java.util.Optional;

public interface ICategoryService {

    Page<Category> getAll(Pageable pageable);

    Page<Category> search(String keyword, Pageable pageable);

    List<Category> findAll();

    Optional<Category> findById(Long id);

    Category save(Category category);

    void deleteById(Long id);

    long count();
}
