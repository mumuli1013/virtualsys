package com.lili.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.lili.domain.GameInfo;
import com.lili.domain.GameUser;
import com.lili.domain.Page;
import com.lili.domain.Pay;
import com.lili.domain.User;
import com.lili.service.GameService;
import com.lili.service.PayService;
import com.lili.service.UserService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/**
 * @author lili
 *2019年1月15日
 * 
 */
public class PayAction extends ActionSupport implements ModelDriven<Pay>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8477214059056210725L;
	private PayService payService;
	public void setPayService(PayService payService) {
		this.payService = payService;
	}

	private GameService gameService;
	public void setGameService(GameService gameService) {
		this.gameService = gameService;
	}
	
	private UserService userService;
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	private Pay pay = new Pay();
	@Override
	public Pay getModel() {
		return pay;
	}

	/**
	 * 支付界面
	 * @return
	 */
	public String PayUI() {
		List<GameInfo> list = gameService.findAllGame();
		ActionContext.getContext().getValueStack().set("list", list);
		return "payUI";
	}
	//获取前台表单数据要在action里面设置get/set方法
	private String name;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	private int vcoin;
	public int getVcoin() {
		return vcoin;
	}
	public void setVcoin(int vcoin) {
		this.vcoin = vcoin;
	}
	//创建订单
	public String createPayOrder() {
		GameUser gu = this.gameService.findUserByName(this.getName());
		if(gu == null)
		{
			this.addActionError("不存在用户");
			List<GameInfo> list = gameService.findAllGame();
			ActionContext.getContext().getValueStack().set("list", list);
			return "payUI";
		}
		else 
		{
			int guid = gu.getId();//游戏用户ID
			GameUser existGUser = this.gameService.isExistGUser(pay.getGameId(),guid); //用游戏ID和游戏用户
			if(existGUser == null)
			{
				this.addActionError("不存在用户");
				List<GameInfo> list = gameService.findAllGame();
				ActionContext.getContext().getValueStack().set("list", list);
				return "payUI";
			}
			else 
			{	
			pay.setGameUserId(guid);
			pay.setVAmount(this.getVcoin());
			//获取用户
			User u = this.userService.findUserById(pay.getUserId());
			//判断虚拟币余额是否充足
			if(this.getVcoin()>u.getVAmount())
			{
				this.addActionError("虚拟币余额不足");
				pay.setStatus(1);
				//保存订单
				this.payService.createPayOrder(pay);
				List<GameInfo> list = gameService.findAllGame();
				ActionContext.getContext().getValueStack().set("list", list);
				return "payUI";
			}
			else
			{
				pay.setStatus(0);
				//更新用户虚拟币数量
				int uvamount = u.getVAmount()-this.getVcoin();
				u.setVAmount(uvamount);
				this.userService.update(u);
				//更新游戏用户虚拟币数量
				int guvamount = gu.getVAmount()+this.getVcoin();
				gu.setVAmount(guvamount);
				this.gameService.updateGUser(gu);
			}
			//保存订单
			this.payService.createPayOrder(pay);	
			return "findOwnerActionUI";
			}
		}
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
		Page<Pay> page = new Page<Pay>();
		page.setBigList(list); //设置 要分页的集合
		page.setCurrentPage(pageNum);
		page.setPageRow(10);
		ActionContext.getContext().getSession().put("page", page);
	}
	public String findById()
	{
		List<Pay> list = (List<Pay>) payService.findById(pay);
		this.findPage(list);
		return "findOwnerUI";
	}
	public String findByIs()
	{
		List<Pay> list = (List<Pay>) payService.findByIs(pay);
		this.findPage(list);
		ActionContext.getContext().getSession().put("status", pay.getStatus());
		return "findOwnerByStatusUI";
	}
	public String findAll()
	{
		List<Pay> list = (List<Pay>) payService.findAll();
		this.findPage(list);
		return "findAllUI";
	}
	public String findAllByStatus()
	{
		List<Pay> list = (List<Pay>) payService.findAllByStatus(pay);
		this.findPage(list);
		ActionContext.getContext().getSession().put("status", pay.getStatus());
		return "findAllByStatusUI";
	}
	private Date startTime;
	private Date endTime;
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public String findByTime() throws ParseException
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String str1 = sdf.format(startTime);
		String str2 = sdf.format(endTime);
		if(Integer.parseInt(str1)>Integer.parseInt(str2))
		{
			this.addActionError("结束日期必须大于开始日期");
			System.out.println(this.getStartTime());
			return "findOwnerUI";
		}
		SimpleDateFormat dataFormat = new SimpleDateFormat("yyyy-MM-dd");
		String st = dataFormat.format(startTime);
		String et = dataFormat.format(endTime);
		List<Pay> list = (List<Pay>) payService.findByTime(st,et,pay);
		this.findPage(list);
		ActionContext.getContext().getSession().put("startTime", this.getStartTime());
		ActionContext.getContext().getSession().put("endTime", this.getEndTime());
		return "findTimeUI";
	}
	
	public String findAllByTime() throws ParseException
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String str1 = sdf.format(startTime);
		String str2 = sdf.format(endTime);
		if(Integer.parseInt(str1)>Integer.parseInt(str2))
		{
			this.addActionError("结束日期必须大于开始日期");
			System.out.println(this.getStartTime());
			return "findOwnerUI";
		}
		SimpleDateFormat dataFormat = new SimpleDateFormat("yyyy-MM-dd");
		String st = dataFormat.format(startTime);
		String et = dataFormat.format(endTime);
		List<Pay> list = (List<Pay>) payService.findAllByTime(st,et);
		this.findPage(list);
		ActionContext.getContext().getSession().put("startTime", this.getStartTime());
		ActionContext.getContext().getSession().put("endTime", this.getEndTime());
		return "findAllByTimeUI";
	}
	
	public String findByGameId() {
		List<Pay> list = (List<Pay>) payService.findByGameId(pay);
		this.findPage(list);
		ActionContext.getContext().getSession().put("gameId", pay.getGameId());
		return "findByGIdUI";
	}
	public String findGIdByTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String str1 = sdf.format(startTime);
		String str2 = sdf.format(endTime);
		if(Integer.parseInt(str1)>Integer.parseInt(str2))
		{
			this.addActionError("结束日期必须大于开始日期");
			System.out.println(this.getStartTime());
			return "findByGIdUI";
		}
		SimpleDateFormat dataFormat = new SimpleDateFormat("yyyy-MM-dd");
		String st = dataFormat.format(startTime);
		String et = dataFormat.format(endTime);
		List<Pay> list = (List<Pay>) payService.findGIdByTime(st,et,pay);
		this.findPage(list);
		ActionContext.getContext().getSession().put("startTime", this.getStartTime());
		ActionContext.getContext().getSession().put("endTime", this.getEndTime());
		ActionContext.getContext().getSession().put("gameId", pay.getGameId());
		return "findGIdByTimeUI";
	}
	public String findGIdByStatus() {
		List<Pay> list = (List<Pay>) payService.findGIdByStatus(pay);
		this.findPage(list);
		ActionContext.getContext().getSession().put("status", pay.getStatus());
		ActionContext.getContext().getSession().put("gameId", pay.getGameId());
		return "findGIdByStatusUI";
	}
	public String checkPay() {
		List<Pay> list = (List<Pay>) payService.findByGameId(pay);
		this.findPage(list);
		ActionContext.getContext().getSession().put("gameId", pay.getGameId());
		return "checkPayUI";
	}
	//统计汇总
	public String findCount() {	
		
		return "findCount";
	}
}
