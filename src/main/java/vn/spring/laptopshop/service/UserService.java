package vn.spring.laptopshop.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.spring.laptopshop.domain.Role;
import vn.spring.laptopshop.domain.User;
import vn.spring.laptopshop.domain.dto.RegisterDTO;
import vn.spring.laptopshop.repository.RoleRepository;
import vn.spring.laptopshop.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    
    public UserService(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    public Page<User> getAllUsers(Pageable pageable){
        return this.userRepository.findAll(pageable);
    }

    public List<User> getAllUsersByEmail(String email){
        return this.userRepository.findOneByEmail(email);
    }
    public User handleSaveUser(User user){
        User vincent = userRepository.save(user);
        System.out.println(vincent);
        return vincent;
    }
    public User getUserById(long id){
        return this.userRepository.findById(id);
    }
    public void deleteUserById(long id){
        this.userRepository.deleteById(id);
    }
    public Role getRoleByName(String name){
        return roleRepository.findByName(name);
    }
    public User transferRegisterToUser(RegisterDTO registerDTO){
        User user = new User();
        user.setFullName(registerDTO.getFirstName() + "" + registerDTO.getLastName());
        user.setEmail(registerDTO.getEmail());
        user.setPassword(registerDTO.getPassword());
        user.setPassword(registerDTO.getConfirmPassword());
        user.setAddress(registerDTO.getAddress());
        user.setPhone(registerDTO.getPhone());
        return user;
    }
    
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    public User getUserByEmail(String email){
        return this.userRepository.findByEmail(email);
    }

    public long countUsers() {
        return this.userRepository.count();
    }
}
