import { connect } from "react-redux"
import DetailSaleCommission from "../../components/saleCommission/detail";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        saleCommissions: state.default.saleCommission.detailSaleCommissions.saleCommissions ? state.default.saleCommission.detailSaleCommissions.saleCommissions  : {},
        currentPage: state.default.saleCommission.detailSaleCommissions.currentPage ? state.default.saleCommission.detailSaleCommissions.currentPage : {} ,
        pageLimit: state.default.saleCommission.detailSaleCommissions.pageLimit ? state.default.saleCommission.detailSaleCommissions.pageLimit : {},
        itemsPerPage: state.default.saleCommission.detailSaleCommissions.itemsPerPage ? state.default.saleCommission.detailSaleCommissions.itemsPerPage : {},
        totalItems: state.default.saleCommission.detailSaleCommissions.totalItems ? state.default.saleCommission.detailSaleCommissions.totalItems : {},
        isFetching:  state.default.saleCommission.detailSaleCommissions.isFetching,
        filters: state.default.saleCommission.detailSaleCommissions.filters ? state.default.saleCommission.detailSaleCommissions.filters : {},
        actions: state.default.env.actions
    }
}

export default connect(mapStateToProps)(DetailSaleCommission);
