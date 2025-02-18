using System.ComponentModel.DataAnnotations.Schema;

namespace FinanzasApp.Models
{
    [Table("transactions")]
    public class Transaction
    {
        // Notar�s que el nombre de la propiedad est� en lowerCamelCase
        public int transactionId { get; set; }
        public string tipo { get; set; }
        public decimal monto { get; set; }
        public DateTime fecha { get; set; }
        public string descripcion { get; set; }
    }
}
