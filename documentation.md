---
title: "Documentation"
author: "Susan S."
date: "October 20, 2015"
output: html_document
---

# Growth of Cell Phones per 100 of Population by Country

This is a simple app that takes data from GapMinder Mobile cellular subscriptions (per 100 people).
Mobile cellular telephone subscriptions are subscriptions to a public mobile telephone service using cellular technology, which provide access to the public switched telephone network. Post-paid and prepaid subscriptions are included.

It plots the data for up to 10 selected countries so the viewer can compare rates of adoption in different countries.
The *selectizeInput* widget is my input.  The operation it performs is selecting which countries to display in the ggplot chart (using subset command).  The reactive output is the chart.
The server.R script subsets the data in the ggplot chart that is generated to include only the selected countries and renders the chart each time the selection is changed.

Data source		<http://www.gapminder.org/data/>
- Source organization(s):	World Bank	
- Link to source organization	<http://data.worldbank.org/indicator>	
- Complete reference	*World Development Indicators*	
- Link to complete reference	<http://data.worldbank.org/indicator/IT.CEL.SETS.P2>

Github repository: <https://github.com/sstreisand/DevDataProductsProject>
