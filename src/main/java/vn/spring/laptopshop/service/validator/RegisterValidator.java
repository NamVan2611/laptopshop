package vn.spring.laptopshop.service.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import vn.spring.laptopshop.domain.dto.RegisterDTO;
import vn.spring.laptopshop.service.UserService;

import org.springframework.stereotype.Service;

@Service
public class RegisterValidator implements ConstraintValidator<RegisterChecked, RegisterDTO> {
    private final UserService userService;

    public RegisterValidator(UserService userService) {
        this.userService = userService;
    }

    @Override
    public boolean isValid(RegisterDTO user, ConstraintValidatorContext context) {
        boolean valid = true;

        // Check if password fields match
        if (!user.getPassword().equals(user.getConfirmPassword())) {
            context.buildConstraintViolationWithTemplate("Passwords must match")
                    .addPropertyNode("confirmPassword")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        // Additional validations can be added here
        if (userService.existsByEmail(user.getEmail())) {
            context.buildConstraintViolationWithTemplate("Email address already in use")
                    .addPropertyNode("email")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        return valid;
    }
}
