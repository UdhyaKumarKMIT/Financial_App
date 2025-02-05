import numpy as np
import datetime as dt
import pandas as pd
import yfinance as yf
import financedatabase as fd
import plotly.express as px
import plotly.graph_objects as go
import streamlit as st

# Page config
st.set_page_config(layout="wide", initial_sidebar_state="expanded")

# App title
st.title("Portfolio Analysis")

# Load ticker list
@st.cache_data
def load_data():
    """Pulls a list of all ETFs and Equities from financedatabase."""
    etfs = fd.ETFs().select().reset_index()[["symbol", "name"]]
    equities = fd.Equities().select().reset_index()[["symbol", "name"]]
    ticker_list = pd.concat([etfs, equities])
    ticker_list = ticker_list[ticker_list.symbol.notna()]
    ticker_list["symbol_name"] = ticker_list.symbol + " - " + ticker_list.name
    return ticker_list

ticker_list = load_data()

# Sidebar
with st.sidebar:
    st.subheader("Portfolio Builder")
    sel_tickers = st.multiselect("Search tickers", ticker_list["symbol_name"])
    sel_tickers_list = ticker_list[ticker_list.symbol_name.isin(sel_tickers)]["symbol"].tolist()

    # Display logos
    cols = st.columns(4)
    for i, ticker in enumerate(sel_tickers_list):
        try:
            cols[i % 4].image(f"https://logo.clearbit.com/{yf.Ticker(ticker).info['website']}")
        except:
            cols[i % 4].subheader(ticker)

    # Date selector
    cols = st.columns(2)
    start_date = cols[0].date_input("Start Date", value=dt.datetime(2024, 1, 1), format="YYYY-MM-DD")
    end_date = cols[1].date_input("End Date", value=dt.datetime.today(), format="YYYY-MM-DD")

# Tabs
tab1, tab2 = st.tabs(["Portfolio", "Calculator"])

# Portfolio Tab
with tab1:
    st.subheader("All Stocks")
    yf_data = yf.download(sel_tickers_list, start=start_date, end=end_date)['Adj Close']
    if not yf_data.empty:
        yf_data = yf_data.pct_change().dropna().reset_index()
        yf_data = yf_data.melt(id_vars=["Date"], var_name="ticker", value_name="price_pct")
        fig = px.line(yf_data, x='Date', y='price_pct', color='ticker', title="Portfolio Performance")
        fig.add_hline(y=0, line_dash="dash", line_color="white")
        fig.update_yaxes(tickformat=".2%")
        st.plotly_chart(fig, use_container_width=True)
    
    # Individual stock plots
    st.subheader("Individual Stocks")
    cols = st.columns(3)
    for i, ticker in enumerate(sel_tickers_list):
        try:
            cols[i % 3].image(f"https://logo.clearbit.com/{yf.Ticker(ticker).info['website']}")
        except:
            cols[i % 3].subheader(ticker)
        
        stock_data = yf.download(ticker, start=start_date, end=end_date)['Adj Close']
        if not stock_data.empty:
            cols2 = cols[i % 3].columns(3)
            cols2[0].metric(label="50-Day Avg", value=round(stock_data.tail(50).mean(), 2))
            cols2[1].metric(label="1-Year Low", value=round(stock_data.tail(365).min(), 2))
            cols2[2].metric(label="1-Year High", value=round(stock_data.tail(365).max(), 2))
