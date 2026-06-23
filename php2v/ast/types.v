module ast

// 语句节点类型
pub const node_stmt_echo = 'Stmt_Echo'
pub const node_stmt_expression = 'Stmt_Expression'
pub const node_stmt_if = 'Stmt_If'
pub const node_stmt_elseif = 'Stmt_ElseIf'
pub const node_stmt_else = 'Stmt_Else'
pub const node_stmt_function = 'Stmt_Function'
pub const node_stmt_return = 'Stmt_Return'
pub const node_expr_funccall = 'Expr_FuncCall'

// 表达式节点类型
pub const node_expr_assign = 'Expr_Assign'
pub const node_expr_variable = 'Expr_Variable'
pub const node_expr_const = 'Expr_ConstFetch'

// 二元运算节点类型
pub const node_bin_plus = 'Expr_BinaryOp_Plus'
pub const node_bin_minus = 'Expr_BinaryOp_Minus'
pub const node_bin_mul = 'Expr_BinaryOp_Mul'
pub const node_bin_div = 'Expr_BinaryOp_Div'
pub const node_bin_mod = 'Expr_BinaryOp_Mod'
pub const node_bin_concat = 'Expr_BinaryOp_Concat'
pub const node_bin_greater = 'Expr_BinaryOp_Greater'
pub const node_bin_smaller = 'Expr_BinaryOp_Smaller'
pub const node_bin_greater_equal = 'Expr_BinaryOp_GreaterOrEqual'
pub const node_bin_smaller_equal = 'Expr_BinaryOp_SmallerOrEqual'
pub const node_bin_equal = 'Expr_BinaryOp_Equal'
pub const node_bin_identical = 'Expr_BinaryOp_Identical'

// 标量节点类型
pub const node_scalar_int = 'Scalar_Int'
pub const node_scalar_float = 'Scalar_Float'
pub const node_scalar_string = 'Scalar_String'
