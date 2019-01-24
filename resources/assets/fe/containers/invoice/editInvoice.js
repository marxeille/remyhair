import { connect } from "react-redux"
import EditInvoice from "../../components/invoice/editInvoice";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        invoice: state.default.invoice.invoice,
        filters: state.default.invoice.filters ? state.default.invoice.filters : {},
        page_number: state.default.invoice.currentPage ? state.default.invoice.currentPage : 1,
        invoices: state.default.invoice.invoices,
    }
}

export default connect(mapStateToProps)(EditInvoice);
