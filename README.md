# Crypto Live
All the information a crypto currency enthusiast could need, packed into one SwiftUI application. Credit goes to [SwiftfulThinking](https://www.youtube.com/@SwiftfulThinking]SwiftfulThinking) (see **Credits** section for more details).

# App Preview
<p align="center">
  <img alt="Light" src="https://imgur.com/zfTrjgD.gif" width="30%">
&nbsp; &nbsp;
  <img alt="Dark" src="https://imgur.com/wEO6BqK.gif" width="30%">
&nbsp; &nbsp;
  <img alt="Dark" src="https://imgur.com/k3UHLI6.gif" width="30%">
</p>

<p align="center">
  <img alt="Light" src="https://imgur.com/ednhLDU.gif" width="30%">
&nbsp; &nbsp;
  <img alt="Dark" src="https://imgur.com/MPQ4WxP.gif" width="30%">
&nbsp; &nbsp;
  <img alt="Dark" src="https://imgur.com/qiXtZiZ.gif" width="30%">
</p>

https://github.com/devrdpatel/CryptoLive/assets/106772575/82a911ed-e4a1-49ec-8653-924cade38e30

# CryptoLive's Purpose
Users can view crypto currency updates live in the app for most popular coins, rather than having to check a coin's price online or having to create a crypto brokerage account. The app also allows users to simulate holdings of a coin at free will to see how their portfolio would perform over a period of time. In addition to crytpo market data, the app also provides additional information about each coin including a 7 day price chart.

# Technologies/Coding Practices
- Combine
- Core Data
- MVVM code architecture

# Technical Details
- All crypto market and currency data is fetched asynchronously using [CoinGecko's API](https://www.coingecko.com/en/api) (Free version limits API calls per min)
- Data fetching services are integrated with Combine's publishers to coordinate all interactions between data services and seamlessly update the UI.
- Network tasks are managed by a custom class that handles URLResponses (such as network errors) and completion events
- Coin images, once fetched, are cached in the File Manager's cachesDirectory
- Portfolio holdings are stored using Core Data
- Custom Chart View created to animate and display live coin price data
- Coins are searchable and can be sorted by rank, holdings, or price
- Project files are organized using MVVM (Model-View-ViewModel) architecture

# Upcoming features
I am currently working on the following features:
- [ ] Giving users the options to view price charts for different time periods
- [ ] Showing users a chart for their portfolio performance over select periods of time
- [ ] Implementing a "buy" and "sell" interface for the Edit Portfolio Holdings View

# Credits
I created this project while following a SwiftUI [course](https://www.youtube.com/playlist?list=PLwvDm4Vfkdphbc3bgy_LpLRQ9DDfFGcFu) on YouTube by [SwiftfulThinking](https://www.youtube.com/@SwiftfulThinking]SwiftfulThinking) so it is almost the same as the app on the channel besides a few modificaitons made by me. The MVVM architecture style used to organize this app's code was also introduced in the course.
