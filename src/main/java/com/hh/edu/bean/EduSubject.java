package com.hh.edu.bean;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.hh.hibernate.dao.inf.Order;

@Order
@SuppressWarnings("serial")
@Entity
@Table(name = "EDU_SUBJECT")
public class EduSubject extends BaseSubject {

}