import { connect } from "react-redux"
import AddInvoice from "../../components/invoice/addInvoice";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        filters: state.default.hair.filters,
        page_number: state.default.hair.currentPage,
        invoices: state.default.invoice.invoices
    }
}

export default connect(mapStateToProps)(AddInvoice);
