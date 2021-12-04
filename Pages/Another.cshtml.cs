using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication2.Pages
{
    public class AnotherModel : PageModel
    {
        private readonly ILogger<AnotherModel> _logger;

        public AnotherModel(ILogger<AnotherModel> logger)
        {
            _logger = logger;
        }

        public void OnGet()
        {
        }
    }
}
