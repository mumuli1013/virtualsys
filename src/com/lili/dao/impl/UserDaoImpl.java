package com.lili.dao.impl;

import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.lili.dao.UserDao;
import com.lili.domain.User;
import com.lili.util.MD5Util;

/**
 * @author lili
 *2018年12月17日
 * 用户DAO层
 * 
 */
public class UserDaoImpl extends HibernateDaoSupport implements UserDao{

	@SuppressWarnings("unchecked")
	@Override
	/**
	 * 通过用户名和密码查询数据
	 */
	public User findByUsernameAndPassword(User user) {
		String hql = "from User where username= ? and password = ? and role = ?";
		List<User> list = this.getHibernateTemplate().find(hql,user.getUsername(),MD5Util.getMd5(user.getPassword()),user.getRole());
		if(list.size() > 0) 
			return list.get(0);
		else
			return null;
	}
	
	//判断用户名是否存在
	@Override
	public User existUsername(String username) {
		String hql = "from User where username=? and role=2";
		List<User> list = this.getHibernateTemplate().find(hql,username);
		if(list.size()>0)
			return list.get(0);
		else
			return null;
	}
	
	//添加用户
	@Override
	public void insertUser(User user) {
		Date currentTime = new Date();
		user.setCreateTime(currentTime);
		user.setUpdateTime(currentTime);
		user.setVAmount(0);  //设定初始虚拟币数量为0
		String md5Pwd = MD5Util.getMd5(user.getPassword());
		user.setPassword(md5Pwd);
		this.getHibernateTemplate().save(user);
	}
	
	//根据id查询用户
	@Override
	public User findUserById(int id) {
		return this.getHibernateTemplate().get(User.class, id);
	}
	
	@Override
	public User isQuestionAndAnswer(User user) {
		String hql = "from User where question=? and answer=? and id=?";
		List<User> list = this.getHibernateTemplate().find(hql,user.getQuestion(),user.getAnswer(),user.getId());
		if(list.size()>0)
			return list.get(0);
		else
			return null;
	}
	
	/**
	 * 更新密码
	 */
	@Override
	public void updatePassword(String password,int id) {
		User user = this.getHibernateTemplate().get(User.class, id);
		String md5Pwd = MD5Util.getMd5(password);
		user.setPassword(md5Pwd);
		Date currentTime = new Date();
		user.setUpdateTime(currentTime);
		this.getHibernateTemplate().update(user);
	}

	@Override
	public int findCountByRole(String hql, User user) {
		List<Long> list = this.getHibernateTemplate().find(hql,user.getRole());
		if(list.size()>0)
			return list.get(0).intValue();
		return 0;
	}

	@Override
	public List<User> findUser(int begin, int pageSize,User user) {
		DetachedCriteria criteria = DetachedCriteria.forClass(User.class).add(Restrictions.eq("role", user.getRole()));
		List<User> list = this.getHibernateTemplate().findByCriteria(criteria,begin,pageSize);
		return list;
	}

	@Override
	public void delete(User user) {
		this.getHibernateTemplate().delete(user);
	}

	@Override
	public User findUserByName(String username) {
		String hql = "from User where username=?";
		List<User> list = this.getHibernateTemplate().find(hql,username);
		if(list.size()>0)
			return list.get(0);
		else
			return null;
	}

	@Override
	public void update(User user) {
		this.getHibernateTemplate().update(user);
	}

	@Override
	public String findNameById(int id) {
		String hql = "from User where id=?";
		List<User> list = this.getHibernateTemplate().find(hql,id);
		if(list.size()>0)
			return list.get(0).getUsername();
		else
			return null;
	}

	@Override
	public List<User> findAllByRole(User user) {
		String hql = "from User where role = ?";
		return this.getHibernateTemplate().find(hql, user.getRole());
	}
	
	
}
