package vn.trungduc.springboot_admin_crud.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@Controller
public class FileController {

    @Value("${app.upload.dir:uploads}")
    private String uploadDir;

    @GetMapping("/uploads/users/{filename:.+}")
    @ResponseBody
    public ResponseEntity<Resource> serveUserAvatar(@PathVariable("filename") String filename, HttpServletRequest request) {
        try {
            List<Path> searchPaths = new ArrayList<>();
            searchPaths.add(Paths.get(uploadDir, "users", filename).toAbsolutePath());
            searchPaths.add(Paths.get("uploads", "users", filename).toAbsolutePath());
            searchPaths.add(Paths.get("src/main/webapp/uploads/users", filename).toAbsolutePath());

            String realPath = request.getServletContext().getRealPath("/uploads/users/" + filename);
            if (realPath != null) {
                searchPaths.add(Paths.get(realPath).toAbsolutePath());
            }

            for (Path path : searchPaths) {
                if (Files.exists(path) && Files.isReadable(path)) {
                    Resource resource = new UrlResource(path.toUri());
                    String contentType = Files.probeContentType(path);
                    if (contentType == null) {
                        String lower = filename.toLowerCase();
                        if (lower.endsWith(".png")) {
                            contentType = "image/png";
                        } else if (lower.endsWith(".gif")) {
                            contentType = "image/gif";
                        } else if (lower.endsWith(".webp")) {
                            contentType = "image/webp";
                        } else {
                            contentType = "image/jpeg";
                        }
                    }
                    return ResponseEntity.ok()
                            .contentType(MediaType.parseMediaType(contentType))
                            .header(HttpHeaders.CACHE_CONTROL, "no-cache, no-store, must-revalidate")
                            .header(HttpHeaders.PRAGMA, "no-cache")
                            .header(HttpHeaders.EXPIRES, "0")
                            .body(resource);
                }
            }
        } catch (Exception ignored) {
        }
        return ResponseEntity.notFound().build();
    }
}
