--Showing Covid Deaths table
--Getting rid of Continent NULL values
SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4 DESC

--Showing Covid Vaccinations table
--Getting rid of Continent NULL values
SELECT *
FROM PortfolioProject..CovidVaccinations
WHERE continent IS NOT NULL
ORDER BY 3,4 DESC

/*Data to be inserted into Tableau to create Visualizations

--Total Cases, Total Deaths, and Death Percentage
SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS int)) as total_deaths, SUM(CAST(new_deaths AS int))/SUM(new_cases) * 100 as Death_Percentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL


--Total Deaths Per Continent
SELECT continent, SUM(CAST(new_deaths AS int)) AS total_deaths
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent

--Percent Population Infected Per Country
SELECT location, SUM(new_cases)/MAX(population) * 100 AS PercentInfected
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY 2 DESC

--Alternative way to do the above for Table 3 (world map)
/*Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc*/

--Percent Population Infected Globally

SELECT Location, Population, Date, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population)) * 100 AS PercentInfected
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population, date
ORDER BY PercentInfected DESC


*/





--ADDITIONAL DATA PULLED


-- Looking at Total Cases vs Total Deaths to find what the death percentage is in the United States
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 AS Percentage_of_Death
FROM PortfolioProject..CovidDeaths
WHERE total_deaths IS NOT NULL AND total_cases IS NOT NULL
--AND location like '%states%'
ORDER BY 5 DESC

--Showing what percentage of the population got Covid
--Might use as a visualization
SELECT location, date, population, total_cases, (total_cases/population) * 100 AS PercentageOfPopulation
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%states%'
ORDER BY 1,2 DESC

--Which countries have the highest infection rate compared to population
SELECT location, population, MAX(total_cases) as HighestInfection, MAX((total_cases/population) * 100) AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%states%'
GROUP BY location, population
ORDER BY 4 DESC

-- Showing countries with the highest death count per population
SELECT location, population, MAX(CAST(total_deaths as int)) AS TotalDeathCount, MAX((CAST(total_deaths as int)/population)* 100) AS PercentDeath
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY 3 DESC

--Breaking it down by countries
--Shows Total Death count for each Country
SELECT location as Country, population, MAX(CAST(total_deaths as int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY 3 DESC
 
--Showing continents with the highest death count per population
SELECT continent, MAX(CAST(total_deaths as int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY 2 DESC

--GLOBAL NUMBERS
--Global number showing total cases, deaths, and death percentage per day
SELECT date, sum(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths as int))/SUM(new_cases) * 100 as DeathPercentage-- total_deaths, (total_deaths/total_cases) * 100 AS Percentage_of_Death
FROM PortfolioProject..CovidDeaths
WHERE total_deaths IS NOT NULL AND
		continent IS NOT NULL
GROUP BY date


--Joining CovidDeaths and CovidVaccinations table
--Looking at Total Population vs Vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
		ON dea.location = vac.location
		AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3


