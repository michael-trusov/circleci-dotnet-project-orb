using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers()
                .AddJsonOptions(option =>
                {
                    option.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
                });

builder.Services.AddRouting(routeOptions =>
{
    routeOptions.LowercaseUrls = true;
    routeOptions.LowercaseQueryStrings = true;
});

var app = builder.Build();
          s
app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();