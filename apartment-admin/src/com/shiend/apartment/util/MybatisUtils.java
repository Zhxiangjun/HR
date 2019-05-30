package com.shiend.apartment.util;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/**
 * 可以获取到sqlsession
 * */
public class MybatisUtils {
	private static SqlSessionFactory sqlSessionFactory ;
	static{
		try {
			//通过流的方式加载mybatis的运行环境
			InputStream in = Resources.getResourceAsStream("mybatis-config.xml");
			//创建会话工厂
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(in);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public static SqlSession getSession(){
		return sqlSessionFactory.openSession();
	}
}
