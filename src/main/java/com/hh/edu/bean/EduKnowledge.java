package com.hh.edu.bean;

import javax.persistence.Entity;

import com.hh.hibernate.dao.inf.Order;
import com.hh.hibernate.util.base.BaseTreeNodeEntity;

@SuppressWarnings("serial")
@Entity(name = "EDU_KNOWLEDGE")
@Order(fields = "order", sorts = "asc")
public class EduKnowledge extends BaseTreeNodeEntity<EduKnowledge> {
}