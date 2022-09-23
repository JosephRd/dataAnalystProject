SELECT * FROM CovidDeaths
SELECT * FROM CovidVaccinations

SELECT continent, location, date, population, total_cases, new_cases, total_deaths
FROM CovidDeaths
where location = 'Indonesia'

--Total case vs Total Deaths percentages
SELECT location, date, total_cases, total_deaths, ((total_deaths/total_cases)*100) AS percentageDeaths
FROM CovidDeaths
order by location, date


--Percentage population infected by covid
SELECT location, date, population, total_cases, (total_cases/population)*100 AS PercentagePopulationInfected
FROM CovidDeaths
ORDER BY location, date


--Country with highest infection count and Compared to population
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population)*100) AS PercentagePopulationInfected
FROM CovidDeaths
GROUP BY location, population
ORDER BY PercentagePopulationInfected DESC


--Country highest death count
SELECT location, MAX(cast(total_deaths as INT)) AS TotalDeathsCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathsCount DESC


--Continent highest death count
SELECT continent, MAX(cast(total_deaths as INT)) AS TotalDeathsCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathsCount DESC


--Global Numbers
SELECT date, SUM(new_cases) AS TotalCases, SUM(cast(new_deaths AS INT)) AS TotalDeaths, SUM(cast(new_deaths AS INT))/SUM(new_cases)*100 AS DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2


--Total population vs Vaccinations
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
SUM(CAST(cv.new_vaccinations AS INT)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS SummingVaccinated
FROM CovidDeaths cd JOIN CovidVaccinations cv ON cd.date = cv.date AND cd.location = cv.location
WHERE cd.continent IS NOT NULL
ORDER BY 2 ,3