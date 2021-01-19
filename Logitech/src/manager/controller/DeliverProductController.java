package manager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import manager.model.InterManagerDAO;
import manager.model.ManagerDAO;
import manager.model.ManagerVO;
import myshop.model.PurchaseDetailVO;

public class DeliverProductController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// @@ 관리자(admin)로 로그인했을 때만 조회가 가능하도록 한다. @@
		HttpSession session = request.getSession();
		ManagerVO loginManager = (ManagerVO)session.getAttribute("loginManager");
		
		if(loginManager != null && ("전체".equals(loginManager.getManagertype()) || "주문".equals(loginManager.getManagertype()))) {
			// 관리자(admin)로 로그인한 경우
			String purchasedetailid = request.getParameter("purchasedetailid");
			String productserialid = request.getParameter("productserialid");
			String stock = request.getParameter("stock");
			
			Map<String, String> paraMap = new HashMap<String, String>();
			
			paraMap.put("purchasedetailid", purchasedetailid);
			paraMap.put("productserialid", productserialid);
			paraMap.put("stock", stock);
			
			InterManagerDAO mdao = new ManagerDAO();
			int n = mdao.updateDelivery(paraMap);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("n", n);
			String json = jsonObj.toString();
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		} else {
			// 로그인하지 않았거나 일반 사용자로 로그인한 경우
			String message = "관리자만 접근할 수 있습니다.";
			String loc = request.getContextPath()+"/manager/signIn.sg";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}// end of if(loginManager != null && "admin".equals(loginManager.getUserid())){}------------------
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {}

}
