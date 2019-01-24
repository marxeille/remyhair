import { connect } from "react-redux"
import AddProduct from "../../../components/sale/product/addProduct";

function mapStateToProps(state) {
    return {
        initData: state.default.sale.initData,
    }
}

export default connect(mapStateToProps)(AddProduct);
