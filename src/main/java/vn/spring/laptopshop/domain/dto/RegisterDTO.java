package vn.spring.laptopshop.domain.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.springframework.web.multipart.MultipartFile;
import vn.spring.laptopshop.service.validator.RegisterChecked;

@RegisterChecked
public class RegisterDTO {
    @NotNull(message = "First Name không được để trống")
    @Size(min = 3, message = "First Name phải có tối thiểu 3 ký tự")
    private String firstName;

    private String lastName;

    @Email(message = "Email không hợp lệ", 
           regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    @NotEmpty(message = "Email không được để trống")
    private String email;

    @NotNull(message = "Password không được để trống")
    @Size(min = 2, message = "Password phải có tối thiểu 2 ký tự")
    private String password;

    private String confirmPassword;

    // 🔽 Thêm các trường mới
    @NotEmpty(message = "Số điện thoại không được để trống")
    private String phone;

    @NotEmpty(message = "Địa chỉ không được để trống")
    private String address;

    // Avatar có thể là ảnh upload, nên dùng MultipartFile
    private MultipartFile avatar;

    // --- Getter & Setter ---
    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }
    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    public MultipartFile getAvatar() {
        return avatar;
    }
    public void setAvatar(MultipartFile avatar) {
        this.avatar = avatar;
    }
}
