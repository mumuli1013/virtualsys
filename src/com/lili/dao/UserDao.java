package com.lili.dao;

import java.util.List;

import com.lili.domain.User;

/**
 * @author lili
 *2018年12月17日
 * 用户DAO层接口
 * 
 */
public interface UserDao {
	//通过用户名和密码查询用户
	User findByUsernameAndPassword(User user);
	//判断用户名是否存在
	User existUsername(String username);
	//添加用户
	void insertUser(User user);
	//根据id查询用户
	User findUserById(int id);
	//更新密码
	void updatePassword(String password,int id);
	//判断问题和答案是否正确
	User isQuestionAndAnswer(User user);
	int findCountByRole(String hql,User user);
	//查看用户
	List<User> findUser(int begin,int pageSize,User user);
	void delete(User user);
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
