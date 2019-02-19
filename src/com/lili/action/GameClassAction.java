package com.lili.action;

import java.util.List;

import com.lili.domain.GameClass;
import com.lili.domain.GameInfo;
import com.lili.domain.Page;
import com.lili.service.GameService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/**
 * @author lili
 *2019年1月12日
 * 
 */
public class GameClassAction extends ActionSupport implements ModelDriven<GameClass>{
	
	//依赖注入业务层
	private GameService gameService;
	public void setGameService(GameService gameService) {
		this.gameService = gameService;
	}
	
	//为ModelDriven提供GameClass对象
	GameClass gameClass = new GameClass();
	@Override
	public GameClass getModel() {
		return gameClass;
	}	
	//跳转到新增游戏分类页面
	public String addUI() {
		return "addUI";
	}
	public String add() {
		GameClass existGC = this.gameService.isExistGC(gameClass);
		if(existGC!=null) {
			this.addActionError("分类已存在");
			return INPUT;
		}else {
			this.gameService.insertGClass(gameClass);
			return "addSuccess";
		}
	}
	
	//进入修改页面
	public String edit() {
	//获取当前ID所有信息
	gameClass = this.gameService.findGClassById(gameClass.getId());
	return "editSuccess";
    }
    //修改
	public String update() {
		this.gameService.updateGClass(gameClass);
		return "updateSuccess";
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
		Page<GameClass> page = new Page<GameClass>();
		page.setBigList(list); //设置 要分页的集合
		page.setCurrentPage(pageNum);
		page.setPageRow(10);
		ActionContext.getContext().getSession().put("page", page);
	}
	public String findAll() {
		List<GameClass> list = (List<GameClass>) this.gameService.findAllGameClass();
		this.findPage(list);
		return "findAll";
	}
}
