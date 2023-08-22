package com.lab.erp.controller.b;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.lab.erp.service.b.B3Service;

@Controller
public class B3Controller {
	private B3Service b3;
	
	@Autowired
	public B3Controller(B3Service b3) {
		this.b3 = b3;
	}
	
	
	// 전자세금계산서
	@GetMapping("/b32main")
	public String b32main(){
		
		
		
		return "/b/b3/b32/b32main";
	}
	
	
	// <전표>
	@GetMapping("/b31main")
	public String b31main(){
		
		
		
		return "/b/b3/b31/b31main";
	}
	
	@GetMapping("/b31insert")
	public String b31insert() {
		
		return "/b/b3/b31/b31insert";
	}
	
	
	
	
	// 외화관리
	@GetMapping("/b33main")
	public String b33mainr() {
		
		
		return "/b/b3/b33/b33main";
	}
	
//	public class ApiExplorer {
//	    public static void main(String[] args) throws IOException {
//	        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1220000/retrieveTrifFxrtInfo/getRetrieveTrifFxrtInfo"); /*URL*/
//	        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=WjGespN29wux4Xj7jLxhXiLVM5JxvOfZUbZy7BVs%2B0JsYWmmqa8DgBDtuM50dvHb%2BQU3jR5Wa1UAB6%2F50Scuiw%3D%3D"); /*Service Key*/
//	        urlBuilder.append("&" + URLEncoder.encode("aplyBgnDt","UTF-8") + "=" + URLEncoder.encode("20150101", "UTF-8")); /*조회년월일*/
//	        urlBuilder.append("&" + URLEncoder.encode("weekFxrtTpcd","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*수출:1, 수입:2*/
//	        URL url = new URL(urlBuilder.toString());
//	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//	        conn.setRequestMethod("GET");
//	        conn.setRequestProperty("Content-type", "application/json");
//	        System.out.println("Response code: " + conn.getResponseCode());
//	        BufferedReader rd;
//	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
//	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//	        } else {
//	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
//	        }
//	        StringBuilder sb = new StringBuilder();
//	        String line;
//	        while ((line = rd.readLine()) != null) {
//	            sb.append(line);
//	        }
//	        rd.close();
//	        conn.disconnect();
//	        System.out.println(sb.toString());
//	    }
//	}
//	
	
	
	
	
	
}
