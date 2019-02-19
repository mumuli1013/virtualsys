package com.lili.action;
/**
 * @author lili
 *2019年1月21日
 * 
 */

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alipay.api.response.AlipayTradePrecreateResponse;
import com.alipay.demo.trade.config.Configs;
import com.alipay.demo.trade.model.ExtendParams;
import com.alipay.demo.trade.model.builder.AlipayTradePrecreateRequestBuilder;
import com.alipay.demo.trade.model.result.AlipayF2FPrecreateResult;
import com.alipay.demo.trade.service.AlipayTradeService;
import com.alipay.demo.trade.service.impl.AlipayTradeServiceImpl;
import com.alipay.demo.trade.utils.ZxingUtils;
import com.lili.domain.Page;
import com.lili.domain.RechargeOrder;
import com.lili.domain.User;
import com.lili.service.RechargeService;
import com.lili.service.UserService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class RechargeOrderAction extends ActionSupport implements ModelDriven<RechargeOrder>{
	private RechargeOrder rechargeOrder = new RechargeOrder();
	@Override
	public RechargeOrder getModel() {
		return rechargeOrder;
	}
	
	private RechargeService rechargeService;
	public void setRechargeService(RechargeService rechargeService) {
		this.rechargeService = rechargeService;
	}
	private UserService userService;
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	private String username;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
		
	public String tradePrecreateUI() {
		return "tradePrecreateUI";
	}
	public String RechargeUI() {
		String outTradeNo = "trade" + System.currentTimeMillis()
        + (long) (Math.random() * 10000000L);
		ActionContext.getContext().getSession().put("outTradeNo", outTradeNo);
		return "rechargeUI";
	}
	public String addRO() {
		User existUser = userService.findUserByName(this.getUsername());
		if(existUser == null)
		{
			this.addActionError("充值账号不存在");
			return INPUT;
		}else {
			this.rechargeOrder.setRechargeUserId(existUser.getId());
    		this.rechargeService.addRO(rechargeOrder);
			return "returnUI";
		}		
	}
	/**
	 * 根据outTradeNo查找订单
	 */
	public RechargeOrder findByNo(String outTradeNo) {
		return this.rechargeService.findByNo(outTradeNo);
	}
	
	//更新
	public void updateROrder(RechargeOrder ro)
	{
		this.rechargeService.updateROrder(ro);
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
		Page<RechargeOrder> page = new Page<RechargeOrder>();
		page.setBigList(list); //设置 要分页的集合
		page.setCurrentPage(pageNum);
		page.setPageRow(10);
		ActionContext.getContext().getSession().put("page", page);
	}
	public String findById()
	{
		List<RechargeOrder> list = (List<RechargeOrder>) rechargeService.findById(rechargeOrder);
		this.findPage(list);
		return "findOwnerUI";
	}
	public String findByIs()
	{
		List<RechargeOrder> list = (List<RechargeOrder>) rechargeService.findByIs(rechargeOrder);
		this.findPage(list);
		ActionContext.getContext().getSession().put("status", rechargeOrder.getStatus());
		return "findOwnerByStatusUI";
	}
	public String findAll()
	{
		List<RechargeOrder> list = (List<RechargeOrder>) rechargeService.findAll();
		this.findPage(list);
		return "findAllUI";
	}
	public String findAllByStatus()
	{
		List<RechargeOrder> list = (List<RechargeOrder>) rechargeService.findAllByStatus(rechargeOrder);
		this.findPage(list);
		ActionContext.getContext().getSession().put("status", rechargeOrder.getStatus());
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
		List<RechargeOrder> list = (List<RechargeOrder>) rechargeService.findByTime(st,et,rechargeOrder);
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
			return "findAllUI";
		}
		SimpleDateFormat dataFormat = new SimpleDateFormat("yyyy-MM-dd");
		String st = dataFormat.format(startTime);
		String et = dataFormat.format(endTime);
		List<RechargeOrder> list = (List<RechargeOrder>) rechargeService.findAllByTime(st,et);
		this.findPage(list);
		ActionContext.getContext().getSession().put("startTime", this.getStartTime());
		ActionContext.getContext().getSession().put("endTime", this.getEndTime());
		return "findAllByTimeUI";
	}
	
	//统计汇总
	public String findCount() {
		
		return "findCount";
	}
}
