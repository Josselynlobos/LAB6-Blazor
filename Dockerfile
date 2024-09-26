FROM mcr.microsoft.com/dotnet/sdk:6.0 As build
WORKDIR /app
RUN git clone https://github.com/MicrosoftDocs/mslearn-intearct-with-dat-blazor-web-apps.git BlazingPizza

COPY ./Index.razor /app/BlazingPizza/Pages/

WORKDIR /app/BlazingPizza

RUN dotnet restore "BlazingPizza.csproj"

RUN dotnet build "BlazingPizza.csproj" -c Release -o /app/build

RUN dotnet publish "BlazingPizza.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/sdk:6.0 As runtime
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 80

CMD [ "dotnet", "BlazingPizza.dll"]