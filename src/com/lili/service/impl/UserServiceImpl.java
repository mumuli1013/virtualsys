package com.lili.service.impl;

import java.util.Date;
import java.util.List;

import com.lili.dao.UserDao;
import com.lili.domain.User;
import com.lili.service.UserService;
import com.lili.util.MD5Util;

/**
 * @author lili
 *2018��12��17��
 * 
 */
public class UserServiceImpl implements UserService {
	private UserDao userDao;

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	/**
	 * 调用dao层实现方法
	 */
	@Override
	public User login(User user) {
		User existUser = userDao.findByUsernameAndPassword(user);
		return existUser;
	}

	@Override
	public User existUsername(String username) {
		// TODO Auto-generated method stub
		return userDao.existUsername(username);
	}

	@Override
	public void insertUser(User user) {
		this.userDao.insertUser(user);
	}

	@Override
	public void updatePassword(String password, int id) {
		this.userDao.updatePassword(password, id);
	}

	@Override
	public User findUserById(int id) {
		return this.userDao.findUserById(id);
	}

	@Override
	public User isQuestionAndAnswer(User user) {
		return this.userDao.isQuestionAndAnswer(user);
	}

	@Override
	public void delete(User user) {
		this.userDao.delete(user);
	}

	@Override
	public User findUserByName(String username) {
		return this.userDao.findUserByName(username);
	}

	@Override
	public void update(User user) {
		Date currTime = new Date();
		user.setUpdateTime(currTime);
		String md5Pwd = MD5Util.getMd5(user.getPassword());
		user.setPassword(md5Pwd);
		this.userDao.update(user);
	}

	@Override
	public String findNameById(int id) {
		return this.userDao.findNameById(id);
	}

	@Override
	public List<User> findAllByRole(User user) {
		return this.userDao.findAllByRole(user);
	}

}
