# שלב 1: יצירת שלב הבניין (Build stage)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# העתק את קובץ ה- csproj ו restore את התלויות
COPY *.csproj ./
RUN dotnet restore

# העתק את שאר הקבצים ו build את האפליקציה
COPY . ./
RUN dotnet publish -c Release -o /app/publish

# שלב 2: יצירת תמונה עם הריצה (Run stage)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# הגדר את הפורט שבו האפליקציה תרוץ
EXPOSE 8080
EXPOSE 8081
ENV ASPNETCORE_ENVIRONMENT=Development
# הרץ את האפליקציה
ENTRYPOINT ["dotnet", "WebApplication2.dll"]

#
## שלב 1: יצירת שלב הבניין (Build stage)
#FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
#WORKDIR /app
#
## העתק את קובץ ה- csproj ו restore את התלויות
#COPY *.csproj ./
#RUN dotnet restore
#
## העתק את שאר הקבצים ו build את האפליקציה
#COPY . ./
#
## שלב 2: שלב הפיתוח
#FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS development
#WORKDIR /app
#COPY --from=build /app .
#
## התקן את dependencies הנדרשים לפיתוח (כולל Swagger במקרה הצורך)
#RUN dotnet tool install --global dotnet-ef  # אם אתה צריך את הכלים של EF
#
## הפעל את ה- WebAPI על פורט 5000
#EXPOSE 5000
#
## הגדר את משתנה הסביבה למצב פיתוח
#ENV ASPNETCORE_ENVIRONMENT=Development
#
## הרץ את האפליקציה במצב פיתוח עם Swagger
#ENTRYPOINT ["dotnet", "WebApplication2.dll"]
#