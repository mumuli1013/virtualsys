package com.lili.action;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.struts2.ServletActionContext;

import com.lili.domain.GameInfo;
import com.lili.domain.Page;
import com.lili.domain.User;
import com.lili.service.GameService;
import com.lili.service.UserService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/**
 * @author lili
 *2018年12月17日
 * 
 */
public class UserAction extends ActionSupport implements ModelDriven<User>{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 9155411607844634771L;
	//接收验证码
	private String checkcode;			
    public void setCheckcode(String checkcode) {
    	this.checkcode = checkcode;
    	}

	private UserService userService;
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	//为ModelDriven提供User对象
	private User user = new User();
	
	@Override
	public User getModel() {
		return user;
	}
	
	private GameService gameService;
	public void setGameService(GameService gameService) {
		this.gameService = gameService;
	}
	/*
	 * 验证码使用
	 */
	private boolean DrawImageUser(String checkcode)
	{
		//判断验证码程序
		//从Session中获得验证码的随机值
		String checkcode1 =(String)ServletActionContext.getRequest().getSession().getAttribute("checkcode");
		if(!checkcode.equalsIgnoreCase(checkcode1)){
			this.addActionError("验证码输入错误!!!");
			return false;
		}
		return true;
	}
	/**
	 * 登录方法
	 * @return
	 */
	public String login() {
		System.out.println("login方法执行了...");
		//判断验证码输入是否正确
		if(this.DrawImageUser(checkcode) == false)
		{
			if(this.user.getRole()==2)
				return "loginUI";
			else if(this.user.getRole()==1)
				return "adminloginUI";
			else
				return "superAdminloginUI";
		}
		//验证码正确则执行以下操作
		//调用业务层方法
		User existUser = userService.login(user);
		if(existUser == null)
		{
			//设置错误信息 对应jsp标签<s:actionerror/>
			this.addActionError("用户名或密码错误!!!");
			if(this.user.getRole()==2)
				return "loginUI";
			else if(this.user.getRole()==1)
				return "adminloginUI";
			else
				return "superAdminloginUI";
		}else {
			if(this.user.getRole()==3)
			{
				this.addActionError("对不起，你已是黑名单用户，无法登录到系统");
				return "loginUI";
				
			}
			//登录验证成功则向前台输出existUser
			ActionContext.getContext().getSession().put("existUser", existUser);
			if(this.user.getRole()==2)
				return "loginSuccess";
			else if(this.user.getRole()==1)
				return "adminUI";
			else
				return "superAdminUI";
		}
		
	}
	/**
	 * 用户注销
	 */
	public String exitLoginUI() {
		System.out.println("exit方法执行了......");
		ActionContext.getContext().getSession().put("existUser", null);
		return "loginUI";
	}
	/**
	 * 跳转到登录页面
	 */
	public String loginUI() {
		return "loginUI";
	}
	/**
	 * 跳转到注册页面
	 */
	public String registerUI() {
		return "registerUI";
	}
	/**
	 * 跳转到忘记密码页面
	 */
	public String forgetPwdUI() {
		return "forgetPwdUI";
	}
	
	public String forgetUI() {
		return "forgetUI";
	}
	/**
	 * 跳转到个人信息页面
	 */
	public String userInfoUI() {
		return "userInfoUI";
	}
	
	/**
	 * 跳转到修改密码页面
	 */
	public String updatePwdUI() {
		return "updatePwdUI";
	}
	/**
	 * 注册
	 */
	public String register() {
		//判断用户名是否已被使用
		User list = userService.existUsername(user.getUsername());
		if(list != null) 
		{
			this.addActionError("用户名已存在");
		    return "registerUI";
		}else 
		{
			//判断验证码输入是否正确
			if(this.DrawImageUser(checkcode) == false)
			{
				if(user.getRole() == 2)
				   return "registerUI";
				else
				{
					List<GameInfo> gamelist = this.gameService.findAllGame();
					ActionContext.getContext().getValueStack().set("gamelist", gamelist);
					return "addAdminUI";
				}
			}
			//验证码正确则执行一下操作
			String regName="[a-zA-Z][a-zA-Z0-9]{4,15}";  //用户名的正则表达式
			String regPwd="[a-zA-Z]\\w{7,15}";           //密码的正则表达式
			Pattern r1=Pattern.compile(regName);
			Pattern r2=Pattern.compile(regPwd);
			Matcher m1=r1.matcher(user.getUsername());
			Matcher m2=r2.matcher(user.getPassword());
			if(!m1.matches()||!m2.matches())
			{
				this.addActionError("用户名或密码格式错误");
				if(user.getRole() == 2)
				    return "registerUI";
				else
				{
					List<GameInfo> gamelist = this.gameService.findAllGame();
					ActionContext.getContext().getValueStack().set("gamelist", gamelist);
					return "addAdminUI";
				}
			}
			else 
			{
				this.userService.insertUser(user);
				if(this.user.getRole()==2)
					return "loginUI";
				else
					return "adminList";
			}
		}
	}
	/**
	 * 查询用户名是否存在
	 */
	public String isExistName()
	{
		User list = this.userService.existUsername(user.getUsername());
		if(list == null)
		{
			this.addActionError("用户名不存在");
			return "forgetPwdUI";
		}else {
			int id = list.getId();
			//登录验证成功则向前台输出existUser
			User existUser = this.userService.findUserById(id);
			ActionContext.getContext().getSession().put("existUser", existUser);
			return "existSuccess";
		}
	}
	
	/**
	 * 忘记密码
	 */
	public String forget() {
		//判断验证码输入是否正确
		if(this.DrawImageUser(checkcode) == false)
			return "forgetUI";
		//判断问题答案是否正确
		User list = this.userService.isQuestionAndAnswer(user);
		if(list == null)
		{
			this.addActionError("问题或答案错误");
			return "forgetUI";
		}else {
			String regPwd="[a-zA-Z]\\w{7,15}";
			Pattern r2=Pattern.compile(regPwd);
			Matcher m2=r2.matcher(user.getPassword());
			if(!m2.matches())
			{
				this.addActionError("密码格式错误");
				return "forgetUI";
			}
			else 
			{
				this.userService.updatePassword(user.getPassword(), user.getId());
				return "loginUI";
			}
		}
	}
	
	/**
	 * 安全设置之修改密码
	 */
	public String updateUserPwd() {
		//判断验证码输入是否正确
		if(this.DrawImageUser(checkcode) == false)
			return "updatePwdUI";
		//判断问题答案是否正确
		User list = this.userService.isQuestionAndAnswer(user);
		if(list == null)
		{
			this.addActionError("问题或答案错误");
			return "updatePwdUI";
		}else {
			String regPwd="[a-zA-Z]\\w{7,15}";
			Pattern r2=Pattern.compile(regPwd);
			Matcher m2=r2.matcher(user.getPassword());
			if(!m2.matches())
			{
				this.addActionError("密码格式错误");
				return "updatePwdUI";
			}
			else 
			{
				this.userService.updatePassword(user.getPassword(), user.getId());
				return "updateSuccess";
			}
		}
		
	}
	//删除
	public String delete() {
		user = this.userService.findUserById(user.getId());
		this.userService.delete(user);
		return "deleteSuccess";
	}
	
	//进入修改页面
	public String edit() {
		user = this.userService.findUserById(user.getId());
		List<GameInfo> gamelist = this.gameService.findAllGame();
		ActionContext.getContext().getValueStack().set("gamelist", gamelist);
		return "editSuccess";
	}
	public String updateUser() {
		//判断验证码输入是否正确
		if(this.DrawImageUser(checkcode) == false)
			return "editUI";
		userService.update(user);
		//更新成功后跳转到用户列表界面
		ActionContext.getContext().getSession().put("role", user.getRole());
		return "updateUserSuccess";
	}
	/**
	 * 分页显示
	 */
	private String currentPage;                  //前端传来的当前页码
	public String getCurrentPage() {
		return currentPage;
	}
 
	public void setCurrentPage(String currentPage) {
		this.currentPage = currentPage;
	}
	public void findPage(List list) {
		//得到当前页
		String currentPage = this.currentPage;
		if(currentPage == null)
			currentPage = "1";
		int pageNum = Integer.parseInt(currentPage);
		Page<User> page = new Page<User>();
		page.setBigList(list); //设置 要分页的集合
		page.setCurrentPage(pageNum);
		page.setPageRow(10);
		ActionContext.getContext().getSession().put("page", page);
	}
	public String findAllByRole()
	{
		List<User> list = (List<User>) this.userService.findAllByRole(user);
		this.findPage(list);
		ActionContext.getContext().getSession().put("role", user.getRole());
		return "userlist";
	}
	public String addAdminUI() {
		List<GameInfo> gamelist = this.gameService.findAllGame();
		ActionContext.getContext().getValueStack().set("gamelist", gamelist);
		return "addAdminUI";
	}
}
