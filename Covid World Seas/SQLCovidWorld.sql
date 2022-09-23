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


-- Using CTE to perform Calculation on Partition By in previous query
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) AS
(
Select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM CovidDeaths cd
JOIN CovidVaccinations cv On cd.location = cv.location AND cd.date = cv.date
WHERE cd.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



-- Using Temp Table to perform Calculation on Partition By in previous query
DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations
, SUM(CONVERT(int,cv.new_vaccinations)) OVER (Partition by cd.Location Order by cd.location, cd.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths cd Join CovidVaccinations cv On cd.location = cv.location and cd.date = cv.date
--where dea.continent is not null 
--order by 2,3

--Check
Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated



-- Creating View to store data for later visualizations
Create View PercentPopulationVaccinated as
Select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations
, SUM(CONVERT(int,cv.new_vaccinations)) OVER (Partition by cd.Location Order by cd.location, cd.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths cd Join CovidVaccinations cv On cd.location = cv.location and cd.date = cv.date
where cd.continent is not null 