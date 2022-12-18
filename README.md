# Seekr Documentation

![ruby](https://img.shields.io/static/v1?message=2.7.4&logo=ruby&style=for-the-badge&label=Ruby&color=darkred&labelColor=crimson) ![ror](https://img.shields.io/static/v1?message=5.2.8.1&logo=rubyonrails&style=for-the-badge&label=Rails&color=crimson&labelColor=darkred) ![Postgres](https://img.shields.io/static/v1?message=14.6&=postgresql&style=for-the-badge&label=Postgresql&color=dodgerblue&labelColor=royalblue&logoColor=white) ![graphql](https://img.shields.io/static/v1?style=for-the-badge&label=&logoColor=white&message=GraphQL&logo=graphql&color=teal&labelColor=green) ![postman](https://img.shields.io/static/v1?message=POSTMAN&logo=postman&style=for-the-badge&label=&color=orangered&labelColor=darkorange&logoColor=white) ![circleci](https://img.shields.io/static/v1?message=CircleCI&logo=circleci&style=for-the-badge&label=&color=mediumaquamarine&labelColor=lightseagreen&logoColor=white)

## Welcome to Seekr

This is a lightweight Rails API that exposes a list of companies known to be currently hiring despite the slowdown in job creation in the tech industry. We wanted to present the data in a way that would serve the needs of those looking for work, so we chose to use GraphQL to simplify and standardize queries. See below for the five endpoints available

### Setting Up Seekr API On Your Machine

After cloning the public repository and cd'ing into `seekr`, follow these steps:

Commands that look `like this` should be run in the terminal from the root folder of the application.

  - Install Bundler
    - `gem install bundler`

  - Run Bundler to install the necessary gems
    - `bundle`

  - Create the local database, run migrations, and populate the company data
    - `rails db:create`
    - `rails db:migrate`
    - `rails csv_load:hiring_companies`

  - Run a local server (defaults to http://localhost:3000)
    - `rails s`

  If everything has gone to plan, you should now be able to call any of the GraphQL endpoints using
    a) an HTTP request client like [Postman](https://www.postman.com/)

    b) your own React Frontend (note that this will require updating `/config/initializers/cors.rb` with your host address)

    c) the GraphiQL dev tools, accessible at http://localhost:3000/graphiql

### Running the Test Suite

  From your terminal, run `bundle exec rspec` to run through the full test suite

## GraphQL Endpoints

### companies

Returns the full data set of companies. Of minimal utility, but it's there if you want it!
#### Sample Request
```
query allCompanies { 
  company {
    companyName
    description
    hiringLink
    rolesHiringFor
    locationsHiringIn
    oneNiceThing
    comments
  }
}
```

#### Sample Response
```
{
"data": {
        "companies": [
            {
                "id": "656",
                "companyName": "1& Mail&Media ",
                "description": "Building on a strong market position with 43 million active users around the world as leading e-mail provider in German, Austria and Switzerland, we develop services and apps that simplify people’s digital lives – from smart mailboxes and cloud storage to personal ID management.",
                "hiringLink": "https://www.mail-and-media.com/en/jobs/job-search.html",
                "rolesHiringFor": "Engineering Manager, DevOps Engineers, Developers, Data Engineers",
                "locationsHiringIn": "Germany (remote), Karlsruhe, Munich, CET",
                "oneNiceThing": "It's mainly the colleagues and atmosphere - and you can very much affect and influence your environment and tasks.",
                "comments": null
            },
            {
                "id": "356",
                "companyName": "10x Banking",
                "description": "Creating the world’s most powerful cloud native banking platform for top tier banks and beyond. ",
                "hiringLink": "https://www.10xbanking.com/job-vacancies",
                "rolesHiringFor": "Business Analysts, DevSecOps, Software Eng (mid, senior, Principal, Lead), Data Engineers",
                "locationsHiringIn": "London, Sydney and Remote ",
                "oneNiceThing": "Microservices architecture and API first design",
                "comments": "We’re a B2B Saas platform with a mission to be the global bank operating system of choice"
            },... 
        ]
    }
}
```

### company

Returns a single company by ID. Probably most useful if, after returning a list of searched companies, we want to be able to click on a company and have a "show" page for it.

Note: all attributes for the companies are strings (handy!)

##### Arguments
    id: Integer

#### Sample Request
```
query getCompanyDetails ($id: ID!) {
  company(id: $id) {
    companyName
    description
    hiringLink
    rolesHiringFor
    locationsHiringIn
    oneNiceThing
    comments
   }
}

variables
{
  "id": 4
}
```

#### Sample Response
```
{
    "data": {
        "company": {
            "companyName": "Findhotel (now Vio.com)",
            "description": "Online hotel booking engine and metasearch",
            "hiringLink": "https://boards.eu.greenhouse.io/findhotel/jobs/4004576101?gh_jid=4004576101  https://boards.eu.greenhouse.io/findhotel/jobs/4042501101?gh_jid=4042501101 https://boards.eu.greenhouse.io/findhotel/jobs/4004552101?gh_jid=4004552101  https://boards.eu.greenhouse.io/findhotel/jobs/4096337101?gh_jid=4096337101",
            "rolesHiringFor": "Software engineers (Golang, Elixir), ML Engineers, Cyber Sec Lead, Engineering manager",
            "locationsHiringIn": "Netherlands; GMT +- 3; Europe, Middle East, Brazil, Argentina, Turkey, Africa",
            "oneNiceThing": "Flexibility",
            "comments": "Findhotel is super multinaitional stable company with no external investment, amazing team and freedom to create and implement things"
        }
    }
}
```

### Search name/description by keyword

This does a *case-insensitive* search on *both* name and description. Best used along side things like "travel" or "fintech" to narrow down companies to the industries in which you're most interested.

##### Arguments
    keyword: String

#### Sample Request
```
query keywordSearchTravel ($keyword: String!) {
  keywordSearch(keyword: $keyword) {
      companyName
      description
      hiringLink
      rolesHiringFor
      locationsHiringIn
      oneNiceThing
      comments
  }
}

variables
{
  "keyword": "travel"
}
```

#### Sample Response
```
{
    "data": {
        "keywordSearch": [
            {
                "companyName": "TravelPerk",
                "description": "Provide a B2B SaaS platform to take the pain out of business travel",
                "hiringLink": "https://www.travelperk.com/careers/",
                "rolesHiringFor": "All software and product roles ",
                "locationsHiringIn": "Barcelona, Berlin, London, Edinburgh ",
                "oneNiceThing": "Work life balance and non corporate (\"we are a family\"), healthy culture.",
                "comments": "https://builders.travelperk.com/how-do-we-hire-engineers-travelperk-afabbf82aedc"
            },
            {
                "companyName": "Skyscanner",
                "description": "Flights, Hotels and Car Hire search\nSearch, compare and book travel\nTravel search and booking",
                "hiringLink": "https://www.skyscanner.net/jobs/current-jobs/\nhttps://www.skyscanner.net/jobs/\nhttps://www.skyscanner.net/jobs/current-jobs/",
                "rolesHiringFor": "Data Engineers, Distributed Systems Engineers, Full Stack Engineers and Engineering Managers\nNative mobile, frontend web, backend node.js/Java/Python\nSoftware engineers and engineering managers ",
                "locationsHiringIn": "London, Barcelona, Edinburgh, Glasgow, Shenzhen\nLondon, Edinburgh, Glasgow, Barcelona\nGlasgow, Edinburgh, London, Barcelona",
                "oneNiceThing": "We're big enough to have exciting challenges with scale, but small enough that our culture is still strong. Plus travel is a fun sector\nGreat culture, transparent and honest leadership\nAmazing culture",
                "comments": null
            },...
        ]
    }
}
```

### Search (multiple)

- Allows you to search multiple qualities simultaneously.

##### Arguments (none required)

    description: String 
    
    locationsHiringIn: String
    
    rolesHiringFor: String
    
    companyName: String

Since the data set is of limited size, many queries using all four arguments won't return any hits. This is meant more to combine things like looking for travel jobs in Europe (see below), but it at least offers the flexibility to be extremely specific if you really want to.
#### Sample Request
```
query searchTravelAndEurope ($description: String!, $locationsHiringIn: String!)
{
    search(
        description: "$description",
        locationsHiringIn: "$locationsHiringIn"
    ) {
        id
        companyName
        description
        locationsHiringIn
        rolesHiringFor
    }
}

variables
{
  "description": "travel",
  "locationsHiringIn": "europe"
}
```

Sample Response
```
{
    "data": {
        "search": [
            {
                "id": "253",
                "companyName": "Busbud",
                "description": "Intercity bus and train travel marketplace",
                "locationsHiringIn": "Based in Montreal, hiring anywhere in NA or Western Europe ",
                "rolesHiringFor": "Senior Engineer, Engineering Manager"
            },
            {
                "id": "741",
                "companyName": "Omio",
                "description": "Travel Tech, Omio is pursuing a vision of delivering the world's travel inventory to enable journeys to and from anywhere.\nWe help people travel especially via trains and buses",
                "locationsHiringIn": "CET - Berlin, Prague, London, Europe Flexi working \nBerlin, Prague, Remote [CET +- 3 hours]",
                "rolesHiringFor": "Multiple Software Engineers Frontend, Backend, FullStack, Java /  JavaScript  / DevOps / ReactNative\nSoftware Engineers - front end, back end, SRE, data; Product Managers; Design roles"
            }
        ]
    }
}
```
