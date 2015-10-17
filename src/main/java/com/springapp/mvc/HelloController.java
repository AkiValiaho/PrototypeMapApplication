package com.springapp.mvc;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.ArrayList;
import java.util.List;
@Controller
@RequestMapping ("/mainPage")
public class HelloController {
	List<Modeluser> listOfHits = new ArrayList<>();
	@RequestMapping (value = "/userForm", method = RequestMethod.GET)
	public String printWelcome() {
		return "hello";
	}
	@RequestMapping (value = "/userForm", method = RequestMethod.POST)
	public String addUser(@RequestBody Modeluser user, BindingResult result, Model m) {
		if (result.hasErrors()) {
			m.addAttribute("errorMessage", "Jätit jonkun tiedon täyttämättä!");
			return "hello";
		}
		System.out.println(user.getName());
		//Palautellaan lista
		listOfHits.add(user);
		//Palautetaan oikea sivu
		return "hello";
	}
	@RequestMapping (value = "/userForm/requestHits", method = RequestMethod.GET)
	public @ResponseBody List<Modeluser> requestHits() {
		//Palautetaan lista JSON-muodossa
		return listOfHits;
	}
}
