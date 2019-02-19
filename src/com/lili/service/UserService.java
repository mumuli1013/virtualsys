package com.lili.service;
import java.util.List;

import com.lili.domain.User;

/**
 * @author lili
 *2018年12月17日
 *用户业务层接口
 * 
 */
public interface UserService {
	//登录
	User login(User user);
	//判断用户名是否存在
	User existUsername(String username);
	//添加用户
	void insertUser(User user);
	//更新密码
	void updatePassword(String password,int id);
	//根据id查询用户
	User findUserById(int id);
	//判断问题和答案是否正确
	User isQuestionAndAnswer(User user);
	void delete(User user);
	//根据用户名查找用户
	User findUserByName(String username);
	//更新用户
	void update(User user);
	//dwr根据ID查找用户名
	String findNameById(int id);
	/**
	 * 分页
	 */
	List<User> findAllByRole(User user);
}
