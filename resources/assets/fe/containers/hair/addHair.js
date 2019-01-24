import { connect } from "react-redux"
import AddHair from "../../components/hair/addHair";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        filters: state.default.hair.filters,
        page_number: state.default.hair.currentPage,
        hairs: state.default.hair.hairs,
        hairColors: state.default.env.hair_colors,
        hairStyles: state.default.env.hair_styles
    }
}

export default connect(mapStateToProps)(AddHair);
