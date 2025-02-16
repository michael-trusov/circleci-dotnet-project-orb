using Microsoft.AspNetCore.Mvc;

namespace Test.Service.Controllers;

[ApiController]
[Route("api/[controller]")]
public class EchoController : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<string>> Get([FromQuery] string? message)
    {
        return Ok(string.IsNullOrWhiteSpace(message) ? 
                        "No query parameter was passed." : message);
    }
}