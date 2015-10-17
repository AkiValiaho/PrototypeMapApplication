package com.springapp.mvc;

import org.hibernate.validator.constraints.NotBlank;

import javax.persistence.Entity;

/**
 * Created by akivv on 23.5.2015.
 */
@Entity
public class Modeluser {
	@NotBlank
	private String name;
	private String id;
	private Float latitude;

	public Float getLongitude() {
		return longitude;
	}
	public void setLongitude(Float longitude) {
		this.longitude = longitude;
	}
	public Float getLatitude(){
		return latitude;
	}
	public void setLatitude(Float latitude) {
		this.latitude = latitude;
	}
	private Float longitude;
	public Modeluser() {
	}
	public Modeluser(String name, String id) {
	    this.id = id;
	    this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
